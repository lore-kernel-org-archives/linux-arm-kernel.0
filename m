From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 19 Jan 2015 11:27:52 +0100
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <20150105135015.GA12010@ulmo.nvidia.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <548ABAB6.6010200@collabora.co.uk> <3197445.qizQc0zeRb@avalon>
 <54914D7D.9060108@collabora.co.uk>
 <CAPj87rN4HZzDt5JBLyTRmKZs7XcOG=0ha7ZQf9hmjPAFgTyhYQ@mail.gmail.com>
 <20150105135015.GA12010@ulmo.nvidia.com>
Message-ID: <54BCDC28.7080003@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thierry,

On 01/05/2015 02:50 PM, Thierry Reding wrote:
> On Fri, Jan 02, 2015 at 01:10:14PM +0000, Daniel Stone wrote:
>> >
>> > Ajay's series don't apply cleanly anymore because it has been a while since
>> > he posted it but he can rebase on top of 3.19-rc1 once it is released and
>> > re-resend.
>> >
>> 
>> Do you have any plans to rebase this so it's ready for merging?
>> 
>> Thierry, Daniel, Dave - whose tree would this be best to merge through?
> 
> The plan is for me to take the bridge patches through the drm/panel
> tree. I'm going to look at these patches again later this week but from
> a very quick peek there don't seem to be any major issues left.
>

I know you probably are very busy but it would be great if you can take a look
to this series to avoid another kernel release to be missed since we are already
at v3.19-rc5.

Only this version was posted 2 months ago and the first version of the series
was sent on May, 2014 so it has been on the list for almost a year now...

Tomi and Laurent had already agreed with the DT binging so I think that we can
already merge these and if there are any remaining issues, those can be fixed
during the 3.20 -rc cycle.

> Thierry
>

Thanks a lot and best regards,
Javier
