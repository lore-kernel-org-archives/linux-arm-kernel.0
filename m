From: nm@ti.com (Nishanth Menon)
Date: Fri, 30 May 2014 16:01:17 -0500
Subject: [PATCH v6 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
In-Reply-To: <5388ED87.1090209@gmail.com>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>
 <1401440477-4328-3-git-send-email-thomas.ab@samsung.com>
 <20140530130827.GK24233@leverpostej>
 <CAJuA9ajs6K1PVtXC4_U0vQsA0oPnpaF_PdMfiQJxBFStF3Z2aw@mail.gmail.com>
 <20140530185549.GN24233@leverpostej> <5388E105.3070609@ti.com>
 <5388E3D2.2060602@gmail.com> <5388E666.2090203@ti.com>
 <5388E7DC.40606@gmail.com> <5388EB21.5020300@ti.com>
 <5388ED87.1090209@gmail.com>
Message-ID: <5388F19D.8070303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2014 03:43 PM, Tomasz Figa wrote:
[...]
> OK, so you add overclocked frequencies to operating-points property,
> boost-frequency property, build a dtb, use it with a kernel that doesn't
> support boost-frequency and nicely overheat (and likely destroy) your
> board. I don't think this makes too much sense, sorry.
Yes, that is unfortunately true as well :( Sigh.

-- 
Regards,
Nishanth Menon
