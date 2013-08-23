From: zonque@gmail.com (Daniel Mack)
Date: Fri, 23 Aug 2013 16:05:30 +0200
Subject: [PATCH v2 2/5] net: ethernet: cpsw: add optional third memory
 region for CONTROL module
In-Reply-To: <52176BB7.3000405@cogentembedded.com>
References: <1377247417-27386-1-git-send-email-zonque@gmail.com>
 <1377247417-27386-3-git-send-email-zonque@gmail.com>
 <52176BB7.3000405@cogentembedded.com>
Message-ID: <52176C2A.9000801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.08.2013 16:03, Sergei Shtylyov wrote:
> On 23-08-2013 12:43, Daniel Mack wrote:

>> +		dev_err(priv->dev, "unable to map control i/o region\n");
> 
>     devm_ioremap_resource() prints out the error messages itself, so you don't 
> have to.

Right. Thanks. Will send a v4.



Best,
Daniel
