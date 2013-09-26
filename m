From: rob@landley.net (Rob Landley)
Date: Wed, 25 Sep 2013 19:10:55 -0500
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <yw1x7ge4x5ir.fsf@unicorn.mansr.com> (from mans@mansr.com on
 Wed Sep 25 10:52:44 2013)
Message-ID: <1380154255.1974.92@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2013 10:52:44 AM, M?ns Rullg?rd wrote:
> Rob Landley <rob@landley.net> writes:
> 
> > On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
> >> I'd strongly suggest you make your binutils compatible with newer
> >> instruction syntax instead of making the kernel more complex.
> >
> > Meaning I play whack-a-mole as this becomes permission to depend on
> > endless new gnuisms just because they're there and nobody else is
> > regression testing against them, not because they actually add  
> anything.
> 
> Since when is assembling the instructions correctly, as specified in  
> the
> arch ref, and not in some other random way a gnuism?

If you require current gnome and drop support for older versions (and  
implicitly all other desktops), people start writing stuff that depends  
on systemd. It doesn't matter if the feature you abandoned support for  
the past 10 years of everthing else for wasn't itself provided by  
systemd.

Rob
