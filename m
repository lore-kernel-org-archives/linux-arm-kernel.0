From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Thu, 06 Jun 2013 20:51:52 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDyPffcN9cNJ10ZHt+AZJHTRdU0LMfCGM_756uAbf+NEBQ@mail.gmail.com>
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
 <CAPweEDyPffcN9cNJ10ZHt+AZJHTRdU0LMfCGM_756uAbf+NEBQ@mail.gmail.com>
Message-ID: <1370544712.31564.11.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tor 2013-06-06 klockan 13:22 +0100 skrev luke.leighton:

>  idea: hook into devicetree gpio functions to allow script-fex gpio
functions to gain access in a separate module?  that sort of thing.

No. Drop FEX from the kernel, use DT. There is no reason why the kernel
shold care about the FEX format.

Translate from FEX to DT where needed in the "firmware" image build
process to allow Allwinner to keep the FEX as hardware description to
the ODMs.

Regards
Henrik
