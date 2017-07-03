From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 3 Jul 2017 12:14:16 +0100
Subject: [STABLE REQ] mm/vmalloc.c: huge-vmap: fail gracefully on
 unexpected huge vmap mappings
In-Reply-To: <20170703084439.GC11757@kroah.com>
References: <CAKv+Gu8yGfECvJj8NhvfqRzDGZ5FrATeQDJAcASot+u+hq31zw@mail.gmail.com>
 <20170703084439.GC11757@kroah.com>
Message-ID: <CAKv+Gu-TGm5ghzMQ=bYubnyoi-s7H-L+o73NShoCO3JUHdCxQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 July 2017 at 09:44, Greg KH <greg@kroah.com> wrote:
> On Tue, Jun 27, 2017 at 02:36:46PM +0000, Ard Biesheuvel wrote:
>> Please consider
>>
>> 029c54b09599 mm/vmalloc.c: huge-vmap: fail gracefully on unexpected
>> huge vmap mappings
>>
>> for inclusion into the v4.9 and v4.11 stable trees. It prevents
>> crashes on arm64 that may occur after commit 324420bf91f6 ("arm64: add
>> support for ioremap() block mappings") was merged for v4.6.
>
> Does not apply to the 4.9-stable tree, can you provide a backport for it
> there?
>

Done.

Regards,
Ard.
