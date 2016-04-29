From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 09:45:38 +0200
Subject: [PATCH v2 00/10] STMPE fixes/rework and add STMPE1600 support
In-Reply-To: <1461845589-4826-1-git-send-email-patrice.chotard@st.com>
References: <1461845589-4826-1-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdYyVBRRrVJhGq_UdWxO2RU3s55nQ4shKyw_t21673a-oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 2:12 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> This series cleans and fixes some bugs in MFD/GPIO STMPE drivers and prepare
>  the ground to add new STMPE1600 support.

This series is finished and looking good from a GPIO perspective.

Lee, once you feel satisfied with the patches and merge them
I'd need an immutable branch, this one I definately have to pull
into the GPIO tree (because of dependent patches).

Yours,
Linus Walleij
