From: linux@baker-net.org.uk (Adam Baker)
Date: Tue, 08 Apr 2014 22:43:10 +0100
Subject: [PATCH 3/3] ARM: kirkwood: rename kirwood-nsa310-common to
 3x0-common
In-Reply-To: <20140408192625.GD29372@lunn.ch>
References: <5341C91D.4060007@baker-net.org.uk>
 <1396820569-3841-1-git-send-email-linux@baker-net.org.uk>
 <1396820569-3841-3-git-send-email-linux@baker-net.org.uk>
 <20140408192625.GD29372@lunn.ch>
Message-ID: <53446D6E.7070909@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/14 20:26, Andrew Lunn wrote:
> On Sun, Apr 06, 2014 at 10:42:49PM +0100, Adam Baker wrote:
>>   Rename the include file kirkwood-nsa310-common.dtsi as
>>   it is now also used for NSA320. There is also an NSA325
>>   but that appears not to be as similar so is unlikely to
>>   want to share an include file.
>>
>> Signed-off-by: Adam Baker <linux@baker-net.org.uk>
>> ---
>>   arch/arm/boot/dts/kirkwood-nsa310-common.dtsi |  157 -------------------------
> ...
>>   arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi |  157 +++++++++++++++++++++++++
>>   5 files changed, 160 insertions(+), 160 deletions(-)
>>   delete mode 100644 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
>>   create mode 100644 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
>
>
> Hi Adam
>
> git should be able to do that as a straight rename, rather than two
> big patch hunks, removing and adding. Try using git mv.
>
> Jason: Are you O.K. with it like this? Or do you want a new minimal
> patch?
>

I did originally perform the rename using git mv but according to 
gitref.org "although the git mv command exists, it is superfluous - all 
it does is a git rm --cached, moves the file on disk, then runs a git 
add on the new file.". Is this something that works better in recent git 
versions, I'm running on Debian stable which uses 1.7.10.4

Adam
