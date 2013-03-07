From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 05:19:03 +0100
Subject: [PATCH] ARM:SPEAr3xx: fix compilation breakage due to missing
 header file
In-Reply-To: <7dd824ea0e7427a203c459fc4084d304ace44c9e.1362461902.git.vipulkumar.samar@st.com>
References: <7dd824ea0e7427a203c459fc4084d304ace44c9e.1362461902.git.vipulkumar.samar@st.com>
Message-ID: <CACRpkdYUHgYHkJWLCYmfjYaDD3A0_S76oBWnC2i40uwW+nRp8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 5, 2013 at 7:04 AM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:

> commit 3a95b9fb (pl080.h: moved from arm/include/asm/hardware to
> include/linux/amba/) broke the compilation for SPEAr3xx machine.
>
> This patch is to include missing header file in spear3xx.c.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
