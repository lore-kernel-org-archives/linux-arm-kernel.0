From: robh@kernel.org (Rob Herring)
Date: Tue, 4 Sep 2018 09:21:05 -0500
Subject: [PATCH] phy: Convert to using %pOFn instead of device_node.name
In-Reply-To: <9dcceda0-1d92-0a7a-feb1-887414021ac9@ti.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-39-robh@kernel.org>
 <9dcceda0-1d92-0a7a-feb1-887414021ac9@ti.com>
Message-ID: <CAL_JsqLrMwd-=Y6rm5RRJ25HNLTxOkFbLMcB4w0UgHteVdidGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 3, 2018 at 9:24 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On Tuesday 28 August 2018 07:22 AM, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
>
> I assume it should be okay to get this merged in the next merge window?

Yes, of course.

Rob
