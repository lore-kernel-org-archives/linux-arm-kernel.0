From: amit.virdi@st.com (Amit Virdi)
Date: Wed, 6 Feb 2013 09:22:39 +0530
Subject: ARM/Kernel: Problems with multiple VIC registration
In-Reply-To: <CACRpkdZX4OyfYbcc2-sdf5LLJmBrGTa27_8swvcZ-rBP6-+1CQ@mail.gmail.com>
References: <5110D55F.9040509@st.com>
 <CACRpkdZX4OyfYbcc2-sdf5LLJmBrGTa27_8swvcZ-rBP6-+1CQ@mail.gmail.com>
Message-ID: <5111D387.9040803@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/5/2013 9:57 PM, Linus Walleij wrote:
> On Tue, Feb 5, 2013 at 10:48 AM, Amit Virdi<amit.virdi@st.com>  wrote:
>
>> The first controller is registered throu' irq_domain_add_linear API. As a
>> result of this call, a new domain is allocated to the VIC device.
>
> This is a bug. Do you have this patch in your tree:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7611/1
>

Yes, I have this patch (from rc2) and still the bug!

Regards
Amit Virdi
