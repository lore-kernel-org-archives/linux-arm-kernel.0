From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Aug 2009 11:25:29 +0200
Subject: ARM Git Tree (at91sam9g45 patches)
In-Reply-To: <9E4512BFD9E74B73A1118E4B0EDE04E9@aeglos>
References: <9f53b4330908251727q1bc1accfk12a9a8d25407791@mail.gmail.com><0F5F73E36031FD46AD3F2E6948F0C0A00188E074@frimb01.corp.atmel.com>	<9f53b4330908252124n168bd094k84f2691ec1a0a0ea@mail.gmail.com>
	<9E4512BFD9E74B73A1118E4B0EDE04E9@aeglos>
Message-ID: <4A94FF89.3000402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Samuelsson :
 > Another important fix is that the AT91bootstrap provides a
> working Rom Code Replacement.bin.
> The one that has been on the Atmel home page is (was) broken.
> I pointed this out last week so they may have changed it by now.

Yes it is available now here (take the _13 revision):
http://www.atmel.com/dyn/resources/prod_documents/AT91SAM9G45_RomCode_Replacement_13.zip

Related documentation is here:
"Errata on AT91SAM9G45 Engineering Sample Devices Errata"
http://www.atmel.com/dyn/resources/prod_documents/doc6485.pdf

Note that all this is not needed with final releases of this chip (not
-ES marking).

Best regards,
-- 
Nicolas Ferre
