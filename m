From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 26 Nov 2009 13:20:25 +0200
Subject: [PATCH 0/8] Omap mux changes for v2.6.33 merge window (Series
	short description)
In-Reply-To: <20091126002038.GH4348@atomide.com>
References: <20091126001646.1546.34352.stgit@localhost>
	<20091126002038.GH4348@atomide.com>
Message-ID: <4B0E6479.50608@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [091125 16:17]:
>> Hi all,
>>
>> Here are some omap mux updates for review. These
>> are intended for the v2.6.33 merge window.
> 
> Forgot to edit the subject :)
> 
> Also, these patches are available in the mux branch
> of the linux-omap tree for easy testing.

After all the discussions we had, what would be preferable way to define the
board mux configuration? The omap_board_mux array or a calls for
omap_mux_init_signal?

> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Sincerely yours,
Mike.
