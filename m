From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 05 Jan 2016 12:09:58 -0800
Subject: Including Raspberry Pi -next trees in linux-next
In-Reply-To: <87d1tfrdu0.fsf@eliezer.anholt.net>
References: <87fuyozzax.fsf@eliezer.anholt.net>
 <20160104182614.4be3fa06@canb.auug.org.au>
 <87d1tfrdu0.fsf@eliezer.anholt.net>
Message-ID: <568C2316.8030302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/16 12:06, Eric Anholt wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
>> Hi Eric,
>>
>> On Sat, 26 Dec 2015 13:15:50 -0800 Eric Anholt <eric@anholt.net> wrote:
>>>
>>> I'll be sending pull-requests to Florian soon, but I would like to get
>>> my trees included in linux-next to get increased testing coverage of
>>> them against everything else going on for 4.5.  I'm expecting to produce
>>> trees under these branch names for the forseeable future.
>>>
>>> Repo: https://github.com/anholt/linux.git
>>>
>>> branches:
>>> drm-vc4-next
>>> bcm2835-dt-next
>>> bcm2835-soc-next
>>> bcm2835-drivers-next
>>> bcm2385-defconfig-next
>>> (bcm2835-maintainers-next is a placeholder since we have nothing for it
>>> this round)
>>
>> I have added the first 5 from today.  Can you tell me which trees they
>> will be merged via so I can position them in my list correctly,
>> please?
> 
> drm-vc4-next goes through airlied's drm-next.  bcm2835-* are intended to
> go through Florian's stblinux tree, though things didn't go that way
> this time because I'm still figuring out timelines.
> 
> Looking through Next/Trees, it looks like stblinux isn't in the list.
> That seems like something that would be useful, given that Florian's
> been successfully sending pull requests to arm-soc for at least a couple
> of releases.  (<1445718981-13552-1-git-send-email-f.fainelli@gmail.com>,
> for example).  His branches appear to be defconfig/next,
> devicetree/next, maintainers/next, and soc/next, all on
> https://github.com/Broadcom/stblinux.git.

Correct, there is also devicetree-arm64/next for ARM64 DTS changes,
which could be helpful to have.
-- 
Florian
