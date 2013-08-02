From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 2 Aug 2013 09:34:20 +0200
Subject: [PATCH 2/10] ARM: dts: mxs: add labels to most nodes for easier
 reference
In-Reply-To: <51F969A1.8070509@wwwdotorg.org>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
 <1375281480-25775-2-git-send-email-LW@KARO-electronics.de>
 <51F969A1.8070509@wwwdotorg.org>
Message-ID: <20987.24828.836885.285381@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Stephen Warren writes:
> On 07/31/2013 08:37 AM, Lothar Wa?mann wrote:
> 
> Are the labels needed? Adding them when they're used might be a better
> approach.
>
I'd prefer to have them defined once, so that possible new users of
the labels won't have to add the labels to this file, which might
produce conflicts when multiple patches try to add the same label to
the file.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
