From: leoyang.li@nxp.com (Li Yang)
Date: Tue, 28 Aug 2018 13:48:01 -0500
Subject: [PATCH] soc: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
Message-ID: <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Please forgive my ignorance, but what is this format specifier do
exactly?   I cannot find anything listed in the printf specification
matching this.  Is this something newly introduced?

Leo
