From: wd@denx.de (Wolfgang Denk)
Date: Fri, 11 Dec 2009 15:33:18 +0100
Subject: "ARM: MX3: fix CPU revision number detection" breaks QONG support
Message-ID: <20091211143318.1D8B43F6CC@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel,

commit v2.6.32-rc6-49-g52939c0 "ARM: MX3: fix CPU revision number
detection" breaks booting on the QONG board - there is no output on
the console any more after this commit is added.

Do you have any idea in which area I should start looking for the
cause of this problem?

Thanks in advance.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
Steal five dollars and you were a petty  thief.  Steal  thousands  of
dollars and you are either a government or a hero.
                                   - Terry Pratchett, _Going_Postal_
