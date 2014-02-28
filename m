From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Feb 2014 16:21:14 +0000
Subject: [PATCH 3/5] documentation/iommu: update description of ARM
 System MMU binding
In-Reply-To: <CAOZdJXUfAygZqw9s5qOECLjyo=B0VaD29iesbWzDeMbbyVTgqg@mail.gmail.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
 <1393002992-24561-4-git-send-email-will.deacon@arm.com>
 <CAOZdJXUfAygZqw9s5qOECLjyo=B0VaD29iesbWzDeMbbyVTgqg@mail.gmail.com>
Message-ID: <20140228162114.GA30996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 04:17:43PM +0000, Timur Tabi wrote:
> On Fri, Feb 21, 2014 at 11:16 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > +- calxeda,smmu-secure-config-access : Enable proper handling of buggy
> > +                  implementations that always use secure access to
> > +                  SMMU configuration registers. In this case non-secure
> > +                 aliases of secure registers have to be used during
> > +                 SMMU configuration.
> 
> I'm confused.  Why does this property have a "calxeda" prefix?  How is
> it a Calxeda-specific property?

Because they wired up their SMMU backwards. It's basically an
implementation-specific erratum workaround.

Will
