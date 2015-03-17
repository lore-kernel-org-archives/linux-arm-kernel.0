From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 17 Mar 2015 18:34:21 +0200
Subject: [PATCH v2 3/3] ARM: mvebu: armada-385-ap: Enable USB3 port
In-Reply-To: <20150317095143.GG4638@lukather>
References: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
 <1421672474-2945-4-git-send-email-maxime.ripard@free-electrons.com>
 <54F4B8B9.4010204@free-electrons.com> <20150303095924.GF4911@lukather>
 <54F5DD7C.1050804@linux.intel.com> <20150317095143.GG4638@lukather>
Message-ID: <5508578D.607@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.03.2015 11:51, Maxime Ripard wrote:
> On Tue, Mar 03, 2015 at 06:12:44PM +0200, Mathias Nyman wrote:
>> On 03.03.2015 11:59, Maxime Ripard wrote:
>>> On Mon, Mar 02, 2015 at 08:23:37PM +0100, Gregory CLEMENT wrote:
>>>> Hi Maxime,
>>>>
>>>> On 19/01/2015 14:01, Maxime Ripard wrote:
>>>>> The Armada 385 AP board has a USB3 port exposed that uses a GPIO to drive the
>>>>> VBUS line. Enable the needed drivers to support this.
>>>>>
>>>>
>>>> it seems that this patch was not applied yet. Patch 1 is now in
>>>> linux-next and should be part of 4.0-rc. But what about patch 2?
>>>
>>> IIRC, Greg or Matthias said that Matthias would look into these
>>> patches after the merge window.
>>>
>>> It still didn't happen though.
>>>
>>> Maxime
>>>
>>
>> Hi
>>
>> I understood that you wanted the first fix patch in as soon as possible so 
>> I sent it forward to Greg, and it's now in his usb-linus branch.
>>
>> The other two patches, 2/3 and 3/3 you said were "regual" patches (for usb-next?),
>> Andrew said he can take 3/3 and wondered if 2/3 and 3/3 need to go together?
>>
>> It doesn't matter for me, I can take 2/3 if you like, but I'd prefer if someone
>> with more USB PHY insight could ack it first.
> 
> There's been around two weeks, and we didn't have any additional
> reviews. How can we move forward on this?
> 

Added to my for-usb-next branch and sent forward to Greg (a second a go)

-Mathias
