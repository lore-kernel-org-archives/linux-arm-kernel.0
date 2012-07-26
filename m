From: zonque@gmail.com (Daniel Mack)
Date: Thu, 26 Jul 2012 19:46:26 +0200
Subject: Current state of AM33xx patches
In-Reply-To: <587C7FB9-2DD3-48EE-B74D-BEBDF199BE23@dominion.thruhere.net>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com>
 <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com>
 <4FE9A00B.6010908@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
 <4FEC7394.9030208@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com>
 <4FEDF54D.4030609@gmail.com>
 <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com>
 <4FEEC7F2.8070507@gmail.com>
 <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com>
 <4FF42761.2000701@gmail.com>
 <EB1619762EAF8B4E97A227FB77B7E0293E9C2548@DBDE01.ent.ti.com>
 <500CEF97.4050207@gmail.com>
 <EB1619762EAF8B4E97A227FB77B7E0293E9D04EB@DBDE01.ent.ti.com>
 <501159C3.3020109@gmail.com>
 <704C899A-606B-41A3-99E8-6D92C0EA5BC5@dominion.thruhere.net>
 <50116926.4060309@gmail.com>
 <587C7FB9-2DD3-48EE-B74D-BEBDF199BE23@dominion.thruhere.net>
Message-ID: <50118272.1050209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.07.2012 18:09, Koen Kooi wrote:
> 
> Op 26 jul. 2012, om 17:58 heeft Daniel Mack <zonque@gmail.com> het
> volgende geschreven:
> 
>> On 26.07.2012 17:00, Koen Kooi wrote:
>> 
>>> With Ajay's usb patches you can easily boot from a usb stick,
>>> you'll only need the bootloads to be on mmc or tftp. That's what
>>> I have been doing on my beaglebone :)
>>> 
>>> I'm going to update 
>>> https://github.com/beagleboard/kernel/tree/beaglebone-3.6 to use 
>>> linus' tree when I get a chance to test a build.
>> 
>> Hmm, how are the patches in this repository generated? Is there a
>> tree that has them as real commits?
> 
> If only! I'm manually pulling them from the mailinglist archives and
> patchwork. I keep hoping for TI to put up a git tree with all their
> WIP stuff, but I guess that goes into the world peace and pony
> category of wanting things.
> 
> Even with this small patchset I'm already having a ton of merge
> conflicts in the .dtsi files which is keeping me from posting my
> patches (e.g. the leds-gpio one) to the proper mailinglists.
> 
> Anyway, enough ranting, mainline + those patches now works on my
> beaglebone so for now I'm a happy camper :)

I'm not on beaglebone here, so things are different. I'd be happy to get
some sniplet that make the cpsw stuff work ...


Daniel
