From: wd@denx.de (Wolfgang Denk)
Date: Tue, 14 Jan 2014 14:47:32 +0100
Subject: AArch64 kernel image decompression
In-Reply-To: <819346bb83b04348a266643afd5bd6f6@BN1PR03MB220.namprd03.prod.outlook.com>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
 <4250104.UfkPP3heXI@wuerfel> <201401141351.18988.marex@denx.de>
 <819346bb83b04348a266643afd5bd6f6@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <20140114134732.F0A1C3821F2@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bhupesh,

In message <819346bb83b04348a266643afd5bd6f6@BN1PR03MB220.namprd03.prod.outlook.com> you wrote:
>
> I agree with Marek. Usually for non-cryptographic-secure (key based cryptography) boot
> method the CRC protection is usually the best possible protection against Image
> corruption. CRC check is usually used in a number of field-deployed solutions to ensure
> linux image sanity. 

The FIT image approach as suggested by Marek also allows for secure
boot methods (like cryptographically signed images); this is used in
production for several systems, including the Google Chromebook.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
Each honest calling, each walk of life, has its own  elite,  its  own
aristocracy based on excellence of performance. - James Bryant Conant
