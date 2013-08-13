From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 14 Aug 2013 07:09:29 +1000
Subject: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
In-Reply-To: <1974929.8mIZF44QnT@vostro.rjw.lan>
References: <5208E2D3.7060005@arm.com> <520A536C.3030600@arm.com>
 <CAL_JsqJdGXuTmb2kgBwgmRYGs9f92-dsawDXSXjmJW8cwjFVQQ@mail.gmail.com>
 <1974929.8mIZF44QnT@vostro.rjw.lan>
Message-ID: <1376428169.4255.16.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-13 at 21:45 +0200, Rafael J. Wysocki wrote:
> 
> I'd go for 1 above personally.

Yuck no. Two functions with roughly the same name and the same purpose
differing only by an underscore just because one can't take 5mn to
reconcile the new one with the old one ? No way.

Ben.
