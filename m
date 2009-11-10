From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 10 Nov 2009 12:27:15 +0900
Subject: [PATCH] ARM: SAMSUNG: Add plat-samsung as starting point for
	plat-s3c* moves
In-Reply-To: <000a01ca61a5$c573d000$505b7000$%kim@samsung.com>
References: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
	<000a01ca61a5$c573d000$505b7000$%kim@samsung.com>
Message-ID: <9c9fda240911091927m46ed0fccyfbbc8873eb9c5da9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 10, 2009 at 10:33 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>
> Hi, everyone
>
> On Tue, Nov 10, 2009 at 9:20PM +0900, Ben Dooks wrote:
>
>> We inted to re-organise the plat-s3c/plat-s3c24xx/plat-s3c64xx into a
>> more generic plat-samsung with less code in the other plat- directories
>> to make it easier to port new devices and try and clear up some of the
>> naming issues with newer devices.

Why do you miss the plat-s5pc1xx? Also add the plat-s5pc1xx series.

>>
>> Start by creating a small arch/arm/plat-samsung with no actuall code in
>> so we can move items in as we process them.
> (snip)
>
> Ok, good.
>
> We will be creating plat-s5p following to plat-samsung and will be submitted
> soon.

Why new plat-s5p is required? The main goal of plat-* directory is
support the SoC common codes.
Of course s5pc100 and s5pc110 is different features and different IPs
but no need to create each plat directory.

Thank you,
Kyungmin Park
