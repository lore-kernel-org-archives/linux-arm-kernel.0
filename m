From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2011 21:03:17 +0000
Subject: [PATCH] MXS: Convert mutexes in clock.c to spinlocks
In-Reply-To: <201112192154.25310.marek.vasut@gmail.com>
References: <1324217174-6574-1-git-send-email-marek.vasut@gmail.com>
 <201112191257.06145.marek.vasut@gmail.com>
 <20111219121559.GF14542@n2100.arm.linux.org.uk>
 <201112192154.25310.marek.vasut@gmail.com>
Message-ID: <20111219210317.GI14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 09:54:25PM +0100, Marek Vasut wrote:
> > So, in summary, you have everything you require to fix it outside the
> > driver.  You just have to decide which of the two options you want to
> > proceed with, and actually (and finally) do it instead of endlessly
> > procrastinating and waiting for more and more bug reports (which is
> > exactly what has happened so far.)
> 
> What the hell, I just recently found this bug and I submitted a patch right 
> away! What are you complaining about?!

If you want to take that attitude to my attempt to help you understand
the problem and see solutions, I'll ignore you permanently for being an
absolute twit.  I'm not going to spend time giving a detailed explaination
about the background and options over something to only then have it
immediately shoved back in my face with such a response.
