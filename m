From: airlied@gmail.com (Dave Airlie)
Date: Wed, 23 Dec 2015 11:33:27 +1000
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move rockchip
 to use it
In-Reply-To: <20151222173800.GU960@e106497-lin.cambridge.arm.com>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <20151222173800.GU960@e106497-lin.cambridge.arm.com>
Message-ID: <CAPM=9twk=M-32cTw4n81RCGhD7ZfmuHKMBS-KR0k+0c=5KD17A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 December 2015 at 03:38, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Fri, Nov 20, 2015 at 02:22:03PM +0000, Liviu Dudau wrote:
>> Hello,
>>
>> This is v2 of the patchset trying to make drm_of_component_probe() cope with finding
>> both local crtc ports and remote encoder ones. Heiko St?bner was nice enough to test
>> an earlier version that was patched following Russell's suggestions on rk3288, but
>> I haven't seen any reports from iMX or Armada users.
>>
>> Changelog:
>>  v2: Updated the drm_of_component_probe() comment to explain why the reference count
>>      is not dropped. Fixed the compare_port() function for rockchip as described by
>>      Russell.
>>  v1: Original submission. http://lists.freedesktop.org/archives/dri-devel/2015-November/094546.html
>
> Gentle ping, this has now been tested by Rockchip people and fixes the earlier version
> that had to be reverted in mainline. Can it be included in the -next somewhere?

It would be good to get Russell ack on the first one, especially after
reading the previous thread.

Dave.
