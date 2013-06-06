From: luke.leighton@gmail.com (luke.leighton)
Date: Thu, 6 Jun 2013 13:22:04 +0100
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <1370477958.20454.68.camel@localhost>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
 <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
 <CAKON4OxwyV2f_iTEb5RnP_azc7EsSxPdku_TY5WLWxN7USiY1Q@mail.gmail.com>
 <CAPweEDw1BabE0cmT5fxZ3Z9p9EH508M3Nzcqk2VcO0oz-qYsvg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <1370477958.20454.68.camel@localhost>
Message-ID: <CAPweEDyPffcN9cNJ10ZHt+AZJHTRdU0LMfCGM_756uAbf+NEBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 1:19 AM, Henrik Nordstr?m
<henrik@henriknordstrom.net> wrote:
> tor 2013-06-06 klockan 00:54 +0100 skrev luke.leighton:
>
>> > Not really the case. Actually the opposite. DT have this as well, and
>> > integrated in device probing. Allwinner need to hack every driver used
>> > to add their gpio requests to have pinmuxing triggered.
>>
>>  augh.  ok.  solutions.  what are the solutions here?
>
> What I said before.

 idea: hook into devicetree gpio functions to allow script-fex gpio
functions to gain access in a separate module?  that sort of thing.

> Go with DT for the kernel. There is no need for two configuration
> mechanisms doing the same thing. Disguise it in fex form (and
> translator) if too hard for people with a DOS editior to configure.

 what methods for doing that.  i need proposals.  4 days on the clock.
