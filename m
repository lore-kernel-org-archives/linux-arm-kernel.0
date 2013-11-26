From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 26 Nov 2013 16:58:38 +0100
Subject: [RESEND PATCH v2 2/3] ARM: Dove: Add DT node for PMU interrupt
 controller.
In-Reply-To: <20131126151806.GL2879@titan.lakedaemon.net>
References: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
 <1383820531-4387-2-git-send-email-andrew@lunn.ch>
 <20131126151806.GL2879@titan.lakedaemon.net>
Message-ID: <5294C52E.2000603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 04:18 PM, Jason Cooper wrote:
> On Thu, Nov 07, 2013 at 11:35:30AM +0100, Andrew Lunn wrote:
>> Instantiate the PMU interrupt controller which Dove has.
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>>   arch/arm/boot/dts/dove.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>
> Could you rebase #2 and #3 on v3.13-rc1?  The dove.dtsi reshuffle last
> window is annoying the piss out of me :)

Jason,

IIRC Andrew isn't available till beginning of Dec. I can rebase if you
want.

Sebastian
