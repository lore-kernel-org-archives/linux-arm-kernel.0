From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 18 May 2013 20:21:25 +0200
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <20130518194644.2a02a4fc@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194644.2a02a4fc@armhf>
Message-ID: <5197C6A5.5070106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2013 07:46 PM, Jean-Francois Moine wrote:
> On Sat, 18 May 2013 19:12:19 +0200
> Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>  wrote:
>
>> The RFC sent by Russell King was missing an include for tda998x. This
>> is just a compatible clone to remember Russell to add that later.
>>
>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
...
> These parameters should not be there. It seems to me that the DT is the
> right place.

True, but if you just read the description above:
"RFC sent by Russell King was missing an include for tda998x".

You want to test the RFC, you need that include.

Sebastian
