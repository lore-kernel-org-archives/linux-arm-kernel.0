From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 17:27:09 +0100
Subject: ARM/Kernel: Problems with multiple VIC registration
In-Reply-To: <5110D55F.9040509@st.com>
References: <5110D55F.9040509@st.com>
Message-ID: <CACRpkdZX4OyfYbcc2-sdf5LLJmBrGTa27_8swvcZ-rBP6-+1CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 5, 2013 at 10:48 AM, Amit Virdi <amit.virdi@st.com> wrote:

> The first controller is registered throu' irq_domain_add_linear API. As a
> result of this call, a new domain is allocated to the VIC device.

This is a bug. Do you have this patch in your tree:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7611/1

Yours,
Linus Walleij
