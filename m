From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 14:06:37 +0100
Subject: [PATCH 0/6] Introduce STMicroelectronics MultiFunction eXpander
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdZYnQC5BusLyK5aAcA2q0NmvHu=TaLhFCfu2M0bgBcjrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amelie,

thanks a lot for your patches!

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This series adds support for STMicroelectronics MultiFunction eXpander
> (ST MFX), used on some STM32 discovery and evaluation boards.

So I take it that the department creating the STMPE
"ST MPE" or "ST Microelectronics MultiPurpose Expander"
Now created a new set of circuits?

Can we first establish whether this new family is really so
different from STMPE that it really needs a new driver in
MFD and GPIO (and I guess pin control as well)?

I would be annoyed to see later that it is just a few bytes
separating it from the STMPE, in that case I think it is
better to just reuse/improve the good old stmpe driver
and take it from there.

Yours,
Linus Walleij
