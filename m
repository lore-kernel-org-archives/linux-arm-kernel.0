From: rob@ti.com (Rob Clark)
Date: Mon, 5 Dec 2011 16:15:11 -0600
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <1781399.9f45Chd7K4@wuerfel>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <201112051718.48324.arnd@arndb.de>
 <CAF6AEGvyWV0DM2fjBbh-TNHiMmiLF4EQDJ6Uu0=NkopM6SXS6g@mail.gmail.com>
 <1781399.9f45Chd7K4@wuerfel>
Message-ID: <CAF6AEGsiSL8x6qETm5zPaQe08=NYOD8eZsASx0e0hkjK3YEj2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 5, 2011 at 4:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> https://github.com/robclark/kernel-omap4/commits/dmabuf
>
> Ok, thanks. I think it would be good to post these for reference
> in v3, with a clear indication that they are not being submitted
> for discussion/inclusion yet.

btw, don't look at this too closely at that tree yet.. where the
attach/detach is done in videobuf2 code isn't really correct.  But I
was going to get something functioning first.

BR,
-R
