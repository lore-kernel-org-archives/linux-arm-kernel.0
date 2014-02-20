From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 20 Feb 2014 16:02:40 +0100
Subject: [PATCH RFC v1 2/3] of: Add definition of maximum length of a
 property name
In-Reply-To: <CAL_Jsq+0pmLHC2Xo=i3kvQMo+uukraK1nRyPZReKtwE_GEaGFQ@mail.gmail.com>
References: <1392829124-25705-1-git-send-email-s.nawrocki@samsung.com>
 <1392829124-25705-3-git-send-email-s.nawrocki@samsung.com>
 <CAL_Jsq+0pmLHC2Xo=i3kvQMo+uukraK1nRyPZReKtwE_GEaGFQ@mail.gmail.com>
Message-ID: <53061910.6040701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/14 22:42, Rob Herring wrote:
> On Wed, Feb 19, 2014 at 10:58 AM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> > Maximum length of a property name is defined by ePAPR (2.2.4.1) as
>> > 31 characters. Add a corresponding definition, including the trailing
>> > null space.
>
> Does dtc enforce this? It would be good to add if not.

As far as I can see there is nothing currently enforcing this in dtc.
There is no related check and too long property names are accepted
silently.
I'll try and see if I can prepare a patch for this, until someone more
familiar with dtc does it.

--
Regards,
Sylwester
