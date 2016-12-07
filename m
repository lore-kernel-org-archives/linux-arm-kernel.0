From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 7 Dec 2016 22:15:55 +0200
Subject: Synopsys Ethernet QoS Driver
In-Reply-To: <87c8a24b-0812-7850-cb3f-7be691bab432@st.com>
References: <CADvZ6ErjyVR5ShWTk0QesWLYR1m3p8yAMkK8v9gm2kN5xTv8zw@mail.gmail.com>
 <1dbb6047-2bbb-4d56-2a62-ab65a0254844@synopsys.com>
 <20161119135654.GA14079@lnxartpec.se.axis.com>
 <CAJ3bTp7PpUJcz=1JohX=A54UP6vVAafWnB0PGUBSxb5JJiO8Lg@mail.gmail.com>
 <1248f4ce-4859-10e6-fef9-342ea543f8d4@synopsys.com>
 <87c8a24b-0812-7850-cb3f-7be691bab432@st.com>
Message-ID: <CAHp75Vf2ZncJcGguueh2fCsHaZVin8qGSk+hDUt+uRg8ffgZbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 2:52 PM, Giuseppe CAVALLARO
<peppe.cavallaro@st.com> wrote:

First of all, +1 to (re-)use stmmac.

> The stmmac drivers run since many years on several platforms
> (sh4, stm32, arm, x86, mips ...) and it supports an huge of amount of
> configurations starting from 3.1x to 3.7x databooks.

As Intel employee who did some clean ups to that, acknowledge above.

> Concerning the stmicro/stmmac naming, these come from a really old
> story and have no issue to adopt new folder/file names.

I don't think it would be best idea for platform driver (though we can
keep driver's name in the structure in async with file name).

-- 
With Best Regards,
Andy Shevchenko
