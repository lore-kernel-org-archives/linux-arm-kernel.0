From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 30 Jul 2013 07:25:17 -0700
Subject: [PATCH 2/2] arm: omap: remove *.auto* from device names given in
 usb_bind_phy
In-Reply-To: <20130730081520.GH16441@radagast>
References: <51F74BC8.7020903@ti.com> <20130730060134.GD9155@radagast>
 <51F7590B.4020705@ti.com> <20130730061830.GE9155@radagast>
 <51F75C40.4060406@ti.com> <20130730062844.GH9155@radagast>
 <51F7613C.5070803@ti.com> <20130730071611.GD16441@radagast>
 <51F7752B.8050804@ti.com> <20130730081520.GH16441@radagast>
Message-ID: <20130730142517.GA29015@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 11:15:20AM +0300, Felipe Balbi wrote:
> > > look at Greg's and my reply to that email.
> > 
> > but finally Greg agreed to what Tomasz proposed no?
> 
> that's not what I see in the thread. I see Greg agreed to regulator's
> own IDs being sequentially created, but he mentions device names can
> change.

And that no one should _ever_ rely on them to be a specific "name", the
bus is responsible for creating the id, it could be "random" and
everything should work just fine.

thanks,

greg k-h
