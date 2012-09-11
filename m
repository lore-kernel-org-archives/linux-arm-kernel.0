From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 11 Sep 2012 13:35:40 +0200
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <20120911123743.29e0ed40@archvile>
References: <20120910171654.1d4972b2@archvile>
 <w51bohddcqw.fsf@mail.mattleach.net>
 <20120911092753.7b8315d4@archvile>
 <20558.61974.299424.536837@pilspetsen.it.uu.se>
 <20120911104925.3461603e@archvile>
 <20559.1844.786507.216580@pilspetsen.it.uu.se>
 <20120911123743.29e0ed40@archvile>
Message-ID: <20559.8716.124212.451155@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Jander writes:
 > > I can make the patches available if there's confirmation that a vanilla
 > > upstream gcc-4.6.3 doesn't work.
 > 
 > I am pretty sure this is the case... do you have a patch series that you can
 > easily tar and mail to me? I'd like to try those patches with OSELAS, to see
 > if I can indeed build a gcc-4.6.3 toolchain that generates correct code.... I
 > already know that I can generate one that doesn't ;-)
 > 
...
 > > If you're sure no add-on patches were applied, then yes please do.
 > 
 > Pretty sure, but not 100%, so I'd like to try your patches first if you don't
 > mind....

And I'd like to confirm first. Please tell us the following:

 > >  > > 2: include the output of gcc -v which tells how that gcc was configured,
 > >  > > 3: give the exact set of gcc options used then compiling the test case.

and I'll check if vanilla upstream gcc is broken or not.
