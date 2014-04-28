From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 28 Apr 2014 19:05:24 +0200
Subject: [PATCH v2 6/7] Documentation: add the Marvell Berlin pinctrl
 documentation
In-Reply-To: <535B7FFC.3000109@gmail.com>
References: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398268276-9696-7-git-send-email-antoine.tenart@free-electrons.com>
 <535B7FFC.3000109@gmail.com>
Message-ID: <20140428170524.GB4211@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Sat, Apr 26, 2014 at 11:44:28AM +0200, Sebastian Hesselbarth wrote:
> On 04/23/2014 05:51 PM, Antoine T?nart wrote:

[?]

> > +A pin-controller node should contain subnodes representing the pin group
> > +configurations, one per group. Each subnode has the group name and the muxing
> 
> ",one per group" isn't correct, is it? You can have one subnode with
> more than one group, like in your example below.

Sure, I forgot to update this one after adding the ability to configure
multiple groups in the same subnode.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
