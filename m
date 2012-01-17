From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Jan 2012 15:49:41 +0530
Subject: [PATCH 8/8] dmaengine/dw_dmac: Add support for DMA_SLAVE_CONFIG
In-Reply-To: <4F153C33.5060805@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <7c1e6fd573d5cd348b22f8363c9960fe5efcd658.1326707233.git.viresh.kumar@st.com>
 <4F140D25.1000309@st.com>
 <CACRpkdbY7ZOwY6GR4t+GODYL4yAdH-PXExmwp84R+Gz2W19X7w@mail.gmail.com>
 <4F153C33.5060805@st.com>
Message-ID: <4F154B3D.7050705@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/17/2012 2:45 PM, Viresh Kumar wrote:
> On 1/17/2012 2:19 PM, Linus Walleij wrote:
>> > Are you looking for ffs() from <linus/bitops.h>?
>> > 
>> > find-first-set (the include boils down to include/asm-generic/bitops/ffs.h
>> > if you want to check the implementation).
> Thanks, but it might not solve the issue. :(
> Actually this will retain the first Least Significant Bit (which is 1)
> and will mark all other zero. So it will give output 0b10 for 0b110
> 

Oops!! I didn't looked at fls in the implementation. :(
You are right. This will solve my issue.

-- 
viresh
