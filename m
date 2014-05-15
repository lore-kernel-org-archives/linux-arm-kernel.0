From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 May 2014 19:18:42 +0100
Subject: [PATCH v4 6/9] regulator: AXP20x: Add support for regulators
 subsystem
In-Reply-To: <5375015A.10701@free-electrons.com>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-7-git-send-email-carlo@caione.org>
 <5375015A.10701@free-electrons.com>
Message-ID: <20140515181842.GQ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 08:03:06PM +0200, Boris BREZILLON wrote:

> I know I'm late, and this patch has already been applied, but shouldn't
> we use of_get_child_by_name instead of of_find_node_by_name.
> This might lead to wrong regulators node parsing if other regulators are
> defined in the DT after the axp20x node, because, AFAIK, this function
> searches for DT nodes defined after the specified np node, but not
> necessarely children of the np node.

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/4c782607/attachment.sig>
