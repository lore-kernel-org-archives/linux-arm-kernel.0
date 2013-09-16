From: denis.ciocca@st.com (Denis CIOCCA)
Date: Mon, 16 Sep 2013 12:23:33 +0200
Subject: [PATCH 32/38] iio: accel-core: st: Move LSM303DLH into correct
 group
In-Reply-To: <20130916101925.GJ3999@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-33-git-send-email-lee.jones@linaro.org>
 <5234A20F.7040008@kernel.org> <20130916080546.GC3999@lee--X1>
 <5236CD17.5010901@st.com> <20130916093812.GG3999@lee--X1>
 <5236D5F0.2030601@st.com> <20130916101925.GJ3999@lee--X1>
Message-ID: <5236DC25.3060909@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I've tried with real device...Unfortunately, you are right for name on
>> the package...
>> So, are you using the LSM303DLHC?
> According to my datasheet [1], I have the LSM303DLH.
>
> [1] http://www.calao-systems.com/repository/pub/EMBEDDED%20COMPUTERS/SKY-S9500-ULP-XXX/C12-SDK/SCH-00103-B11.pdf
>
Mhh...I saw the LSM303DLHC...
The LSM303DLH is not populated, there is only the footprint but is not 
soldered...

Denis
