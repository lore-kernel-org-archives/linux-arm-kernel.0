From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Mar 2013 17:44:46 +0800
Subject: [PATCH v8 04/12] regulator: palmas correct dt parsing
In-Reply-To: <1362662276-20792-4-git-send-email-ian@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <1362662276-20792-4-git-send-email-ian@slimlogic.co.uk>
Message-ID: <20130308094443.GD28481@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 01:17:48PM +0000, Ian Lartey wrote:
> From: Graeme Gregory <gg@slimlogic.co.uk>
> 
> Fix the DT parsing to agree with the bindings document. Some small changes
> to the value names and also fix the handling of boolean values. They were
> previously using prop = 1/0, now just use of_property_read_bool calls.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/3dc92202/attachment.sig>
