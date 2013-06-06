From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Thu, 06 Jun 2013 20:44:42 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDzrYL5c9v1T=nTcyv9RPrJ-TEnCyyjpHQnhXXJY-32=5g@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
 <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
 <CAKON4OxwyV2f_iTEb5RnP_azc7EsSxPdku_TY5WLWxN7USiY1Q@mail.gmail.com>
 <CAPweEDw1BabE0cmT5fxZ3Z9p9EH508M3Nzcqk2VcO0oz-qYsvg@mail.gmail.com>
 <CAKON4Oz79hUE_ReAqjeynwL6ZWntX2W1uw3YOg0G2AiY7Gjs=g@mail.gmail.com>
 <CAPweEDyO+Sc1aQ64HBeh1OSzmPNsnwMwEo5kbHSan5vw_YEjXA@mail.gmail.com>
 <1370477756.20454.65.camel@localhost>
 <CAPweEDzrYL5c9v1T=nTcyv9RPrJ-TEnCyyjpHQnhXXJY-32=5g@mail.gmail.com>
Message-ID: <1370544282.31564.5.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tor 2013-06-06 klockan 13:19 +0100 skrev luke.leighton:

>  mass-volume tablet, mass-volume IPTV box.  android OS, nothing else.

Which still includes a number of possible configurations with different
i2c, spi, usb etc devices connected on the board. Because Allwinner is
not using mainline methods for configuration their customers are stuck
in only selecting between a very limited set of "Allwinner compatible"
auxillary chips (g-sensors, led controls, wifi modules, gps modules etc)
in their designs.

By using DT their customers are free to choose any device supported
mainline.

Regards
Henrik
