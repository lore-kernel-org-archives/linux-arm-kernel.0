From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 11 Aug 2015 15:56:45 +0200
Subject: [PATCH 2/2] drm: sti: adapt DT to fix probe/bind issues in DRM
 driver
In-Reply-To: <55A8EC3F.6050903@st.com>
References: <1437133510-13615-1-git-send-email-benjamin.gaignard@linaro.org>
 <1437133510-13615-2-git-send-email-benjamin.gaignard@linaro.org>
 <55A8EC3F.6050903@st.com>
Message-ID: <55C9FF1D.8050702@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 07/17/2015 01:51 PM, Maxime Coquelin wrote:
> Dear ARM SoC Maintainers,
>
> On 07/17/2015 01:45 PM, Benjamin Gaignard wrote:
>> STI drm drivers probe and bind using component framework was incorrect.
>> In addition to drivers fix DT update is needed to make all 
>> sub-components
>> become childs of sti-display-subsystem.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> ---
>>   arch/arm/boot/dts/stih407.dtsi | 82 
>> +++++++++++++++++++++---------------------
>>   arch/arm/boot/dts/stih410.dtsi | 82 
>> +++++++++++++++++++++---------------------
>>   2 files changed, 80 insertions(+), 84 deletions(-)
>>
>>
>
> This patch solves an issue preventing DRM driver probing, but it 
> breaks the DT ABI.
> For now, this driver and its DT node are only used by a few identified 
> people.
>
> Since these people only use aligned version of Kernel and DT, do you 
> accept we break the ABI for this time?
>

Just a gentle reminder.
Can we derogate for this patch?

Thanks in advance,
Maxime
