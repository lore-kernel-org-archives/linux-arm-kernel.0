From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 05 Nov 2009 12:33:20 +0100
Subject: [PATCH 0/6] mx31moboard: patches for next merge window v2
In-Reply-To: <20091105074000.GF14091@buzzloop.caiaq.de>
References: <1257268191-19075-1-git-send-email-valentin.longchamp@epfl.ch>
	<20091105074000.GF14091@buzzloop.caiaq.de>
Message-ID: <4AF2B800.3080001@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sacha,

Daniel Mack wrote:
> On Tue, Nov 03, 2009 at 06:09:45PM +0100, Valentin Longchamp wrote:
>> The main peripheral that we are using and that still is missing is the USB
>> host, but since the driver still needs a few improvements, I keep it aside
>> for now.
> 
> It has been added to Greg's usb-linux tree now. And I posted some more
> versions of the ulpi viewport support to Sascha and the linux-usb ML
> (unfortunately, someone culled the arm-linux ML from Cc which I realized
> way too late).
> 
> So, if Sascha applied the ulpi patch, all pieces should be on their way
> to mainline now. Finally :)
> 

Cool that all pieces now are on the way to mainline.

Since the ulpi patch is the only remaining part, are you going to push 
it for the next release ?

If yes I will add my mx31moboard USB patch to the ones that could be 
pushed for the next arm merge window.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
