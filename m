From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Apr 2013 10:31:45 +0200
Subject: [PATCH v2 2/9] arm: mvebu: Align the internal registers virtual
 base to support LPAE
In-Reply-To: <515F3E96.4040307@free-electrons.com>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
 <201304052250.28641.arnd@arndb.de> <515F3E96.4040307@free-electrons.com>
Message-ID: <201304061031.45598.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Gregory CLEMENT wrote:
> On 04/05/2013 10:50 PM, Arnd Bergmann wrote:
> > On Friday 05 April 2013, Gregory CLEMENT wrote:
> >> From: Lior Amsalem <alior@marvell.com>
> > 
> > This is a surprising limitation. Can you extend the above text to go into more
> > detail where that alignment requirement comes from?
> > 
> 
> The explanation I had was that in LPAE section size is 2MB, in earlyprintk we map
> the internal registers and it must be section aligned.
> 

Ah, I see. Please put that in the text then.

	Arnd
