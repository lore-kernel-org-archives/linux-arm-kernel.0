From: denis.ciocca@st.com (Denis CIOCCA)
Date: Mon, 16 Sep 2013 11:57:04 +0200
Subject: [PATCH 32/38] iio: accel-core: st: Move LSM303DLH into correct
 group
In-Reply-To: <20130916093812.GG3999@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-33-git-send-email-lee.jones@linaro.org>
 <5234A20F.7040008@kernel.org> <20130916080546.GC3999@lee--X1>
 <5236CD17.5010901@st.com> <20130916093812.GG3999@lee--X1>
Message-ID: <5236D5F0.2030601@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> That's what the datasheet for the board says. Perhaps it's that that's 
> incorrect? Annoyingly, instead of printing the device name on the 
> package, ST put some non-Googleable nonsense is there instead 
> (probably the serial number). Nevertheless, I'll revert the patch and 
> work something else out.

I've tried with real device...Unfortunately, you are right for name on 
the package...
So, are you using the LSM303DLHC?

Denis
