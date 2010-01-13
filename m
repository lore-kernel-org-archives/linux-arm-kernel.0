From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 13 Jan 2010 21:27:57 +0100
Subject: Question: __ARM_EABI__
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
Message-ID: <19278.11469.95923.629825@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten writes:
 > Hello all,
 > 
 > The following commit added a check for __ARM_EABI__ and raises a
 > warning if it's not defined.
 > 
 > commit 6603a4fd5195a004dec5f9568e38ff76bae630c1
 > Author: Claudio Scordino <claudio@evidence.eu.com>
 > Date:   Fri Oct 30 12:06:05 2009 +0100
 > 
 >     ARM: 5776/1: Check compiler version and EABI support when adding ARM unwind support.
 > 
 > Where is this definition supposed to come from?

The C compiler used to compile the kernel.

 > I am using an EABI compiler but the warning still shows up.

Then your compiler is broken, or you haven't told it to be EABI.

gcc-4.4 works.
