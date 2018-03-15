From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 16:41:15 +0100
Subject: [PATCH] serial: stm32: fix initialization of RS485 mode
In-Reply-To: <1521103480-6940-1-git-send-email-bich.hemon@st.com>
References: <1521103480-6940-1-git-send-email-bich.hemon@st.com>
Message-ID: <CAK8P3a3sn4Z70VHXQmLV344uCX-a1=H=6m-yTy1HxFQMQRiHrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 9:44 AM, Bich HEMON <bich.hemon@st.com> wrote:
> Configure RS485 mode during port initialization.
>
> Fixes: 1bcda09d291081a7732fcaa9d1745312404a4e36 ("serial: stm32: add
> support for RS485 hardware control mode")
>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

I noticed the unused-function warning from the original patch, and the
patch also fixes that (besides looking like it does the right thing).

Acked-by: Arnd Bergmann <arnd@arndb.de>
