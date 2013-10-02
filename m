From: jdl@jdl.com (Jon Loeliger)
Date: Wed, 02 Oct 2013 08:22:58 -0500
Subject: [RFC 00/15] Device Tree schemas and validation
In-Reply-To: <524BE66D.7060308@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com> <E1VR1hx-0000C1-6J@jdl.com>
 <524BE66D.7060308@baylibre.com>
Message-ID: <E1VRMOI-0006iA-TF@jdl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> > Benoit,
> >
> > Sorry, I meant to ask earlier but forgot.
> > Shouldn't this development be based on the
> > upstream DTC repository and not the in-kernel
> > copy of the DTC?
> 
> Eventually, yes,

We should *start* there, though.

> but here the main point is to discuss the schema that 
> will be used to defined bindings.
> In that case, the DTC patches code are mostly a proof of concept

Sure; all that is fine.

> using the Linux kernel as example.

Example?(*)  We shouldn't churn the kernel.

jdl

(*) In the sense that *this* Universe is just
    one example from all known Universes? :-)
