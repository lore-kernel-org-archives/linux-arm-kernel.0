From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Mon, 28 Sep 2009 11:43:46 +0200
Subject: Problem with mxc_nand driver
In-Reply-To: <a57e67db0909280241w61f8d8bbm88ff5d749cc946c2@mail.gmail.com>
References: <a57e67db0909272341k59d4cda6pde85ff7425a75c8f@mail.gmail.com>	
	<4AC0682D.6000907@eukrea.com>	
	<a57e67db0909280156x686f0d26u397dc6397fd0b3a@mail.gmail.com>	
	<4AC07FF9.2040002@eukrea.com>
	<a57e67db0909280241w61f8d8bbm88ff5d749cc946c2@mail.gmail.com>
Message-ID: <4AC08552.2070009@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jernej Turnsek a ?crit :
> after writing root fs image into nand partition, running the image and
> then checking the first empty block I've got following OOB data which
> is suspicious to me:
> 
> OOB:
> 	ff ff 85 19 03 20 ff ff
> 	ff 65 02 08 00 00 00 ff
> 	ff ff ff ff ff ff ff ff
> 	ff ff 03 ff ff ff ff ff
> 	ff ff ff ff ff ff ff ff
> 	ff ff 03 ff ff ff ff ff
> 	ff ff ff ff ff ff ff ff
> 	ff ff 03 ff ff ff ff ff
> 
> One can see that bytes on offset 2 to 5 are not empty and when using
> the smallpage_memorybased badblock_pattern byte 6 is not FF like it
> should be.
> 
> Anyone knows what is going on here?
> 
which configuration are you using ? SW ECC + without the commit ?

Eric
