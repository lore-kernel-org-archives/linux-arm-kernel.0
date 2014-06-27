From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 15:46:10 +0100
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <53AD7C24.5090408@gmail.com>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk> <53AD724D.4020704@gmail.com>
 <20140627133933.GJ23978@titan.lakedaemon.net> <53AD7544.2060701@gmail.com>
 <20140627135932.GI32514@n2100.arm.linux.org.uk> <53AD7C24.5090408@gmail.com>
Message-ID: <20140627144610.GK32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 04:13:56PM +0200, Sebastian Hesselbarth wrote:
> On 06/27/2014 03:59 PM, Russell King - ARM Linux wrote:
>> This is kind'a my point - you're confirming that you can't reliably
>> tell which version you have by running something on the cubox itself.
>> As Jason points out, there are those who need to choose the correct
>> DT file when installing.
>>
>> So, this means that the user has to be asked.  If users have to be
>> asked, users need some way to identify the hardware that they're
>> running on.
>
> I get your point, but there is no way to automatically tell them apart.
> IMHO, that is why cubox-dove.dts should represent the *production*
> version.

That's why I'm saying maybe there shouldn't be a distinction at DT
level - AFAIK the GPIO-based detection also works on the production
version.

>> No, I didn't know until recently, because my Cubox was given to me by
>> Nicolas Pitre a couple of years ago - that's the problem, the engineering
>> samples may not be with the original people and therefore their origins
>> may not be known.
>
> It is printed on the box it came in ;)

Yea, that's why it took a year and a half for me to find out which
model I had.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
