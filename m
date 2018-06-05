From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Tue, 5 Jun 2018 17:50:57 +0200
Subject: [alsa-devel] [PATCH 0/3] ASoC: stm32: sai: add support of iec958
 controls
In-Reply-To: <20180417111733.GG8973@sirena.org.uk>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
 <20180417111733.GG8973@sirena.org.uk>
Message-ID: <2ae6c5b6-872a-9aaa-6ca4-e29adb7c8bc0@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takashi,

On 04/17/2018 01:17 PM, Mark Brown wrote:
> On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:
> 
>> I guess the blocking patch in this patchset is the patch "add IEC958 
>> channel status control helper". This patch has been reviewed several 
>> times, but did not get a ack so far.
>> If you think these helpers will not be merged, I will reintegrate the 
>> corresponding code in stm driver.
>> Please let me know, if I need to prepare a v2 without helpers, or if we 
>> can go further in the review of iec helpers patch ?
> 
> I don't mind either way but you're right here, I'm waiting for Takashi
> to review the first patch.? I'd probably be OK with it just integrated
> into the driver if we have to go that way though.

Gentlemen reminder for this patch set. We would appreciate to have your
feedback on iec helper.
>From our point of view it could be useful to have a generic management
of the iec controls based on helpers instead of redefining them in DAIs.
Having the same behavior for these controls could be useful to ensure
coherence of the control management used by application (for instance
Gstreamer uses it to determine iec raw mode capability for iec61937 streams)


Thanks,
Arnaud
