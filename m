From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 8 Oct 2010 11:20:24 +0300
Subject: [RFC] tidspbridge: use a parameter to allocate shared memory
In-Reply-To: <4CAE1CA1.4050006@ti.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
	<201010070940.14208.laurent.pinchart@ideasonboard.com>
	<4CADFCEB.4030008@ti.com>
	<AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>
	<4CAE1CA1.4050006@ti.com>
Message-ID: <AANLkTikHMewD94ZBb9P4AF9oM2ZfnpA-yjO67Dx2Lg9r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 7, 2010 at 10:16 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> On 10/7/2010 1:22 PM, Felipe Contreras wrote:
>> Anyway, we will not know for sure until we try... Right?
>
> yes we can try, at least we now for sure arm side can be done.

The only thing that changes is the cacheability of the ARM side
memory, so of course only the ARM side matters. The DSP side will
continue to do what it's doing and would not notice any difference if
the memory is flushed, or is non-cacheable.

-- 
Felipe Contreras
