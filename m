From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 13 Nov 2018 18:02:09 +0100
Subject: [PATCH v3 17/18] USB: phy-mv-usb: use phy-pxa-usb
In-Reply-To: <20181112032027.653931-18-lkundrak@v3.sk> (Lubomir Rintel's
 message of "Mon, 12 Nov 2018 04:20:26 +0100")
References: <20181112032027.653931-1-lkundrak@v3.sk>
 <20181112032027.653931-18-lkundrak@v3.sk>
Message-ID: <87tvkkkj1q.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> Use a proper PHY driver, instead of hooks to a board support package.
Hi Lubomir,

This specific patch caught my attention, because of its title : I don't see what
phy-pxa-usb stands for, is it a typo ? I don't think anybody implemented so far
a proper phy support for pxa based boards (pxa27x actually), hence my question.

Cheers.

--
Robert
