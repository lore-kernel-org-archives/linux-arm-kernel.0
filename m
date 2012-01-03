From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Jan 2012 12:58:39 -0800
Subject: [PATCH v2 1/2] Input: tegra-kbc - add device tree bindings
In-Reply-To: <20120102081828.GB18381@ponder.secretlab.ca>
References: <1325053170-6984-1-git-send-email-olof@lixom.net>
 <1325053170-6984-2-git-send-email-olof@lixom.net>
 <20120102081828.GB18381@ponder.secretlab.ca>
Message-ID: <CAOesGMg_MKGenRyTa9PkSLvV3CsWxYcY=sGb5awPQn=9Ng8ENQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 2, 2012 at 12:18 AM, Grant Likely <grant.likely@secretlab.ca> wrote:

> I'd like to see a "tegra," prefix on these custom properties, but otherwise
> the binding looks okay to me. ?You should also consider a '-ms' suffix on
> the millisecond properties.

Ok, I added "nvidia," prefix for the properties, and pushed down the
linux,fn-keymap binding to this level (but I left the implementation
as a FIXME).

> Otherwise;
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks, added and I'll repost the patch together with the shared
binding in a bit.


-Olof
