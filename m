From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 15 Apr 2011 21:52:01 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
In-Reply-To: <1302896541.30441.33.camel@dev.znau.edu.ua>
References: <BANLkTim7Uj2tsgFngWhUqFK_hk3Leg+sQA@mail.gmail.com>
	<1302781431.21145.6.camel@dev.znau.edu.ua>
	<BANLkTinvpt5vs+rXd3WN-a2JpGtTV+=Gyg@mail.gmail.com>
	<4DA6E9BD.3090404@hauke-m.de>
	<BANLkTinu+Q367oqQPiUehPcbMs-SBxbwFg@mail.gmail.com>
	<1302786900.21965.52.camel@dev.znau.edu.ua>
	<BANLkTimM8=-pX+Ea8Eyp4XyvP1APbUof9w@mail.gmail.com>
	<1302892585.30441.12.camel@dev.znau.edu.ua>
	<BANLkTi=16i+D8frz3X2f+JDtp4hbJKLL3A@mail.gmail.com>
	<1302896541.30441.33.camel@dev.znau.edu.ua>
Message-ID: <BANLkTinPVaYC14Y=m5iu7GYodkRb6uTuPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 15 kwietnia 2011 21:42 u?ytkownik George Kashperko
<george@znau.edu.ua> napisa?:
> So, we could start with introducing virtual "ocp" bus (which could be of
> some use for other vendors utilising ocp model) with additional
> library/module for broadcom-specific extensions (accounting for
> buscommon/buscore/etc.).

I think we over-complicate that.


> On other hand just broadcom-specific bus looks like good alternative too
> but here I just fail to decide on relevant naming.

Just bcmamba / bcmaxi?

-- 
Rafa?
