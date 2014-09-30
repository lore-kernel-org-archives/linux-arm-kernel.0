From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 01 Oct 2014 00:01:53 +0200
Subject: [PATCH v6 00/10] ARM: Berlin: Ethernet support
In-Reply-To: <20140930.163735.2099691931550261883.davem@davemloft.net>
References: <1412087296-18475-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140930.163735.2099691931550261883.davem@davemloft.net>
Message-ID: <542B2851.2050705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.09.2014 22:37, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@free-electrons.com>
> Date: Tue, 30 Sep 2014 16:28:06 +0200
>
>> This series introduce support for the Ethernet controller on Berlin SoCs,
>> using the existing pxa168 Ethernet driver. In order to do this, DT
>> support is added to the driver alongside some other modifications and
>> fixes.
>>
>> This has been tested on a Berlin BG2Q DMP board.
>
> Applied to net-next, thanks.

David,

usually I'd prefer to take the dts patches through berlin and arm-soc
tree, _but_ as they are touching berlin stuff only I am fine with you
taking them, too.

Just to make sure how long I have to take care of potential merge
issues, is your current net-next meant for v3.18 or v3.19?

Sebastian
