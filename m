From: robherring2@gmail.com (Rob Herring)
Date: Thu, 09 Feb 2012 12:20:33 -0600
Subject: hex number case in dts files.
In-Reply-To: <20120209180411.GA5654@codeaurora.org>
References: <20120209180411.GA5654@codeaurora.org>
Message-ID: <4F340E71.7070004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2012 12:04 PM, David Brown wrote:
> I've noticed an inconsistency in the case of letters in hex constants
> in various dts files.  The ones that are actually numbers probably
> don't really matter, the but the node names are case sensitive
> strings, and in some sense do matter.
> 
> I ask because some people I've spoken with internally seem to have
> strong opinions about what case hex constants should be, and it'd be
> nice to be able to have some guideline about this.  Historically, I've
> always seen DT hex values in lowercase.
> 

Lower case should be used for dts files.

Rob
