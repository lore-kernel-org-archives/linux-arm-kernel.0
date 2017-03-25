From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 24 Mar 2017 22:21:44 -0700
Subject: [PATCH 4/9] bus: brcmstb_gisb: Use register offsets with writes
 too
In-Reply-To: <20170324144632.5896-5-opendmb@gmail.com>
References: <20170324144632.5896-1-opendmb@gmail.com>
 <20170324144632.5896-5-opendmb@gmail.com>
Message-ID: <CADtm3G74w9rAB==APUqDTZL307E9mCtWZgw3BWLP08B1C+tCBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 7:46 AM, Doug Berger <opendmb@gmail.com> wrote:
> This commit corrects the bug introduced in commit f80835875d3d
> ("bus: brcmstb_gisb: Look up register offsets in a table") such
> that gisb_write() translates the register enumeration into an
> offset from the base address for writes as well as reads.
>
> Fixes: f80835875d3d ("bus: brcmstb_gisb: Look up register offsets in a table")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
