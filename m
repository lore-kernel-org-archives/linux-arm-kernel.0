From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 11:19:25 +0100
Subject: [PATCH 32/38] iio: accel-core: st: Move LSM303DLH into correct
 group
In-Reply-To: <5236D5F0.2030601@st.com>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-33-git-send-email-lee.jones@linaro.org>
 <5234A20F.7040008@kernel.org> <20130916080546.GC3999@lee--X1>
 <5236CD17.5010901@st.com> <20130916093812.GG3999@lee--X1>
 <5236D5F0.2030601@st.com>
Message-ID: <20130916101925.GJ3999@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > That's what the datasheet for the board says. Perhaps it's that that's 
> > incorrect? Annoyingly, instead of printing the device name on the 
> > package, ST put some non-Googleable nonsense is there instead 
> > (probably the serial number). Nevertheless, I'll revert the patch and 
> > work something else out.
> 
> I've tried with real device...Unfortunately, you are right for name on 
> the package...
> So, are you using the LSM303DLHC?

According to my datasheet [1], I have the LSM303DLH.

[1] http://www.calao-systems.com/repository/pub/EMBEDDED%20COMPUTERS/SKY-S9500-ULP-XXX/C12-SDK/SCH-00103-B11.pdf

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
