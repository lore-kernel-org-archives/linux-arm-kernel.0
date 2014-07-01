From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 01 Jul 2014 15:40:14 +0200
Subject: [PATCH 4/4] ARM: mvebu: add armada drm init to Dove board setup
In-Reply-To: <20140701133627.GP32514@n2100.arm.linux.org.uk>
References: <1404219871-18419-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1404219871-18419-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140701131026.GO32514@n2100.arm.linux.org.uk> <53B2B5E5.50502@gmail.com>
 <20140701133627.GP32514@n2100.arm.linux.org.uk>
Message-ID: <53B2BA3E.1010705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 03:36 PM, Russell King - ARM Linux wrote:
> On Tue, Jul 01, 2014 at 03:21:41PM +0200, Sebastian Hesselbarth wrote:
>> On 07/01/2014 03:10 PM, Russell King - ARM Linux wrote:
>>> On Tue, Jul 01, 2014 at 03:04:31PM +0200, Sebastian Hesselbarth wrote:
>>> If you want to do this then you need to add the endpoints from the start
>>> even though the driver doesn't yet make use of them - or don't add the
>>> DT bits at all.
>>
>> If you really think that way, I definitely give up on mainline Dove and
>> SolidRun Cubox. You are /really/ proposing to wait for *all* related
>> subsystem bindings to settle before even starting to add DT support?
>
> *Sigh*.

Russell,

honestly, I am out. Feel free to take over anything you want. I
understand you are in a bad mood because you feel ignored on your
patches, but for me your attitude is unbearable and *the* reason
to step back now.

Sebastian
