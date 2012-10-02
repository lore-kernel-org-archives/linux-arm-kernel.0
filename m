From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 2 Oct 2012 12:04:29 +0200
Subject: How many cores does the ARM branch support?
In-Reply-To: <20121002043106.GD21233@work1>
References: <20121002043106.GD21233@work1>
Message-ID: <20121002100429.GA5117@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06:31 Tue 02 Oct     , Michelle Konzack wrote:
> Hello OverGeeks and *,
> 
> I have gotten a new gadget which run only with 700MHz but has  32 cores.
> Support 16 GE Interfaces a 50 Gbit universal interface and 4 PCIe ports,
> SATA HDD and much more...
> 
> ...and yes, this ARM microcontroller is a telecommunications controller.
> 
> However, I have the Evaluation  Kit  and  a  PCIe  graphiccard  and  now
> installed Debian ARMEL.  Unfortunately I get only 2 cores working...
> 
> What must I do to get the other 30 cores?
32 cores on arm? which soc is it

usualy the nr_cpus is set to 2 check it
> 
> (without them, my Marvel Discovery MV78200 us 5 times faster)
> 
> And is it possibel, to get 100 cores running?
> (this is the bigger version of the microcontroller I have)
> 
> I like to transform the 32 and 100 core versions into PanelPCs with  the
> ultimate super power...  :-D  ...even it will be only a gadget for me!
Best Regards,
J.
> 
> Thanks, Greetings and nice Day/Evening
>     Michelle Konzack
> 
> -- 
> ##################### Debian GNU/Linux Consultant ######################
>    Development of Intranet and Embedded Systems with Debian GNU/Linux
>                Internet Service Provider, Cloud Computing
>                 <http://www.itsystems.tamay-dogan.net/>
> 
> itsystems at tdnet                     Jabber  linux4michelle at jabber.ccc.de
> Owner Michelle Konzack
> 
> Gewerbe Strasse 3                   Tel office: +49-176-86004575
> 77694 Kehl                          Tel mobil:  +49-177-9351947
> Germany                             Tel mobil:  +33-6-61925193  (France)
> 
> USt-ID:  DE 278 049 239
> 
> Linux-User #280138 with the Linux Counter, http://counter.li.org/



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
