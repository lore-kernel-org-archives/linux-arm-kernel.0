From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 15 Apr 2013 09:11:26 +0300
Subject: [PATCH v9 1/6] rpmsg: Process all available messages in virtqueue
 callback
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C1431230582@DFLE12.ent.ti.com>
References: <1364521307-1219-1-git-send-email-rtivy@ti.com>
 <1364521307-1219-2-git-send-email-rtivy@ti.com>
 <CAK=WgbaCtACsvt9cqQmGqXsADFb_3bfnNKeWq9iijR2vkYVuQQ@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C1431230345@DFLE12.ent.ti.com>
 <CAK=WgbbpJuh8M4FLEgQKzbOPadJFHO=gvpA2jVOrN5N1g=1f2w@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C1431230582@DFLE12.ent.ti.com>
Message-ID: <CAK=WgbZeAqy_u0R_oOKn7ovE7Rqkj3sNcg2rwgMMXvJBGRFrsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 9, 2013 at 11:56 PM, Tivy, Robert <rtivy@ti.com> wrote:
> This new function also uses an 'int err;', so the above line should not be removed.

Added, thanks!

> I added the above-mentioned 'int err;' to my tree's rpmsg_recv_single() and tested it out, it worked well.  So once that is corrected, you can add:
> Acked-by: Robert Tivy <rtivy@ti.com>

No need to add your Acked-by as you are the author :)

Applied - will show up in linux next soon, please check it out there.

Thanks,
Ohad.
